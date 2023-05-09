import {
  Controller,
  Post,
  Body,
  UseGuards,
  Put,
  Delete,
  Query,
} from '@nestjs/common';
import { FriendService } from './friend.service';
import { AuthGuard } from '@nestjs/passport';
import { JwtGuards } from 'src/decorator/jwt.guard';
@Controller('friend')
export class FriendController {
  constructor(private friendService: FriendService) {}
  @Post('/send')
  @JwtGuards()
  sendFriendRequest(@Body() body: any) {
    return this.friendService.sendFriendRequest(
      body.recipient_id,
      body.requester_id,
    );
  }
  @Put('/accept')
  @JwtGuards()
  acceptFriendRequest(@Body() body: any) {
    return this.friendService.acceptFriendRequest(body.request_id);
  }
  @Delete('/remove')
  @JwtGuards()
  removeFriendRequest(@Query() params: any) {
    return this.friendService.removeFriendRequest(params.request_id);
  }
  @Put('/accept_by_user_ids')
  @JwtGuards()
  acceptFriendByUserIds(@Body() body: any) {
    return this.friendService.acceptFriendRequestByUserIds(
      body.requester_id,
      body.recipient_id,
    );
  }
  @Delete('/remove_by_user_ids')
  @JwtGuards()
  removeFriendByUserIds(@Query() params: any) {
    return this.friendService.removeFriendByUserIds(
      params.user_id_1,
      params.user_id_2,
    );
  }
}
