import { Inject, Injectable } from '@nestjs/common';
import { Server, Socket } from 'socket.io';

@Injectable({})
export class WebSocketService {
  constructor(
    // @Inject('SERVER') private readonly server: Server,
    @Inject('USER_SOCKETS')
    private readonly userSockets: { [userId: string]: Socket[] },
  ) {}
  handleConnection(socket: Socket) {
    console.log(`Người dùng đã kết nối ${socket.id}`);
    const userId = socket.handshake.query.user_id as string;
    if (!this.userSockets[userId]) {
      this.userSockets[userId] = [];
    }
    this.userSockets[userId].push(socket);
  }
  handleDisconnect(socket: Socket) {
    console.log(`Người dùng đã ngắt kết nối ${socket.id}`);
    const userId = socket.handshake.query.user_id as string;
    const userSockets = this.userSockets[userId];
    if (userSockets) {
      const updatedSockets = userSockets.filter((s) => s.id !== socket.id);
      if (updatedSockets.length === 0) {
        delete this.userSockets[userId];
      } else {
        this.userSockets[userId] = updatedSockets;
      }
    }
  }
  sendToUser(userId: string, event: string, data: any) {
    const userSockets = this.userSockets[userId];
    if (userSockets) {
      userSockets.forEach((socket) => {
        socket.emit(event, data);
      });
    }
  }
}
