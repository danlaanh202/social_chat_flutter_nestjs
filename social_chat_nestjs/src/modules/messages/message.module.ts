import { Module } from '@nestjs/common';
import { MessageController } from './message.controller';
import { JwtStrategy } from '../auth/strategy/jwt.strategy';
import { MessageService } from './message.service';
import { WebsocketGateway } from 'src/websocket/websocket.gateway';
import { ChatService } from '../chats/chat.service';

@Module({
  controllers: [MessageController],
  providers: [JwtStrategy, MessageService, ChatService],
  exports: [MessageService],
})
export class MessageModule {}
