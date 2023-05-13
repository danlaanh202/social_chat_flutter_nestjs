import { Inject, Injectable } from '@nestjs/common';
import { Server, Socket } from 'socket.io';

@Injectable({})
export class WebSocketService {
  constructor(
    @Inject('USER_SOCKETS')
    private readonly userSockets: { [userId: string]: Socket[] },
  ) {}

  sendToUser(server: Server, userId: string, event: string, data: any) {
    const _userSockets = this.userSockets[userId];
    if (_userSockets) {
      _userSockets.forEach((socket) => {
        server.to(socket.id).emit(event, data);
      });
    }
  }
}
