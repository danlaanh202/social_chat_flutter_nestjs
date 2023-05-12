import { Module } from '@nestjs/common';
import { AuthModule } from './modules/auth/auth.module';
import { PrismaModule } from './modules/prisma/prisma.module';
import { ConfigModule } from '@nestjs/config';
import { UserModule } from './modules/users/user.module';
import { ChatModule } from './modules/chats/chat.module';
import { FriendModule } from './modules/friends/friend.module';
import { MessageModule } from './modules/messages/message.module';
import { WebSocketModule } from './websocket/websocket.module';

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
    }),
    PrismaModule,
    AuthModule,
    UserModule,
    ChatModule,
    FriendModule,
    MessageModule,
    WebSocketModule,
  ],
})
export class AppModule {}
