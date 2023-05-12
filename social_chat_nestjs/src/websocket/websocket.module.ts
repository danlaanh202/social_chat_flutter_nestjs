import { Module } from '@nestjs/common';
import { WebsocketGateway } from './websocket.gateway';
import { MessageService } from 'src/modules/messages/message.service';
import { WebSocketService } from './websocket.service';

@Module({
  controllers: [],
  providers: [
    WebsocketGateway,
    MessageService,
    WebSocketService,
    // {
    //   provide: 'SERVER',
    //   useExisting: WebsocketGateway,
    // },
    {
      provide: 'USER_SOCKETS',
      useValue: {},
    },
  ],
})
export class WebSocketModule {}
