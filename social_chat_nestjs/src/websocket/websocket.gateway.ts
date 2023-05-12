import { WebSocketService } from './websocket.service';
import { Inject, UseGuards } from '@nestjs/common';
import {
  WebSocketGateway,
  WebSocketServer,
  SubscribeMessage,
  OnGatewayInit,
  OnGatewayConnection,
  OnGatewayDisconnect,
} from '@nestjs/websockets';
import { Server, Socket } from 'socket.io';
import { MessageService } from 'src/modules/messages/message.service';

@WebSocketGateway()
export class WebsocketGateway implements OnGatewayInit {
  constructor(
    private readonly messageService: MessageService,
    @Inject('USER_SOCKETS')
    private readonly userSockets: { [userId: string]: Socket[] }, // private readonly socketService: WebSocketService,
  ) {}
  @WebSocketServer()
  server: Server;

  handleConnection(client: Socket) {
    console.log(`Người dùng đã kết nối ${client.id}`);
    const userId = client.handshake.query.user_id as string;
    if (!this.userSockets[userId]) {
      this.userSockets[userId] = [];
    }
    this.userSockets[userId].push(client);
  }
  afterInit(server: Server) {
    console.log('WebSocket gateway initialized', server);
  }
  handleDisconnect(client: any) {
    console.log(`Người dùng đã ngắt kết nối ${client.id}`);
    const userId = client.handshake.query.user_id as string;
    const userSockets = this.userSockets[userId];
    if (userSockets) {
      const updatedSockets = userSockets.filter((s) => s.id !== client.id);
      if (updatedSockets.length === 0) {
        delete this.userSockets[userId];
      } else {
        this.userSockets[userId] = updatedSockets;
      }
    }
  }
  @SubscribeMessage('message')
  async handleMessage(client: any, payload: any) {
    try {
      const message = await this.messageService.createMessage({
        content: payload.content,
        chat_id: payload.chat_id,
        my_id: payload.my_id,
      });

      this.server.emit('receive_message', message);
      // this.server.emit('message_error', 'Something wrong with this');
    } catch (error) {
      this.server.emit('message_error', 'Something wrong with this');
    }
  }
}
