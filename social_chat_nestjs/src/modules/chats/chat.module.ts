import { Module } from '@nestjs/common';
import { ChatController } from './chat.controller';
import { ChatService } from './chat.service';
import { JwtStrategy } from '../auth/strategy/jwt.strategy';

@Module({
  imports: [],
  providers: [ChatService, JwtStrategy],
  controllers: [ChatController],
})
export class ChatModule {}
