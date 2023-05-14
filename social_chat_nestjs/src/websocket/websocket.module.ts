import { Module } from '@nestjs/common';
import { WebsocketGateway } from './websocket.gateway';
import { MessageService } from 'src/modules/messages/message.service';
import { WebSocketService } from './websocket.service';
import { ChatService } from 'src/modules/chats/chat.service';

@Module({
  controllers: [],
  providers: [
    WebsocketGateway,
    MessageService,
    WebSocketService,
    ChatService,
    {
      provide: 'USER_SOCKETS',
      useValue: {},
    },
  ],
})
export class WebSocketModule {}
