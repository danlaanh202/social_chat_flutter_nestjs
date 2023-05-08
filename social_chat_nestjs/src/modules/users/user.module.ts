import { Module } from '@nestjs/common';
import { UserController } from './user.controller';
import { UserService } from './user.service';
import { FriendService } from '../friends/friend.service';

@Module({
  controllers: [UserController],
  providers: [UserService, FriendService],
})
export class UserModule {}
