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
@Controller('friend')
export class FriendController {
  constructor(private friendService: FriendService) {}
  @Post('/send')
  @UseGuards(AuthGuard('jwt'))
  sendFriendRequest(@Body() body: any) {
    return this.friendService.sendFriendRequest(body);
  }
  @Put('/accept')
  @UseGuards(AuthGuard('jwt'))
  acceptFriendRequest(@Body() body: any) {
    return this.friendService.acceptFriendRequest(body.request_id);
  }
  @Delete('/remove')
  @UseGuards(AuthGuard('jwt'))
  removeFriendRequest(@Query() params: any) {
    return this.friendService.removeFriendRequest(params.request_id);
  }
}
