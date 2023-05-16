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
import { ChatService } from 'src/modules/chats/chat.service';
import { MessageService } from 'src/modules/messages/message.service';

@WebSocketGateway({
  cors: true,
})
export class WebsocketGateway
  implements OnGatewayConnection, OnGatewayDisconnect
{
  constructor(
    private readonly messageService: MessageService,
    @Inject('USER_SOCKETS')
    private readonly userSockets: { [userId: string]: Socket[] },
    private readonly socketService: WebSocketService,
    private readonly chatService: ChatService,
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
  @SubscribeMessage('room')
  handleJoinRoom(client: any, payload: any) {
    console.log(`Có user đã join room: ${client.id}`);
    client.join(payload.chat_id);
  }
  @SubscribeMessage('room_seen')
  async handleSeenRoom(client: any, payload: any) {
    console.log(`seen room ${client.id}`);
    const chat = await this.chatService.updateIsViewed(payload.room_id, true);
    this.socketService.sendToUser(
      this.server,
      payload.my_id,
      'room_seen_receive',
      { seen: true, roomId: payload.room_id },
    );
  }
  @SubscribeMessage('message')
  async handleMessage(client: any, payload: any) {
    try {
      const message = await this.messageService.createMessage({
        content: payload.content,
        chat_id: payload.chat_id,
        my_id: payload.my_id,
      });
      this.socketService.sendToRoom(
        this.server,
        payload.chat_id,
        'message_receive_room',
        message,
      );
      this.socketService.sendToUser(
        this.server,
        message.chat.members[0].user_id,
        'message_receive',
        message,
      );
      this.server.to(client.id).emit('message_receive', message);
    } catch (error) {
      this.server.emit('message_error', 'Something wrong with this');
    }
  }
}
