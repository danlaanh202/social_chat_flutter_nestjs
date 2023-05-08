import { Module } from '@nestjs/common';
import { FriendController } from './friend.controller';
import { FriendService } from './friend.service';
import { JwtStrategy } from '../auth/strategy/jwt.strategy';

@Module({
  providers: [FriendService, JwtStrategy],
  controllers: [FriendController],
})
export class FriendModule {}
