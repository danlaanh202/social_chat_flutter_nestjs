import { Body, Controller, Get, Post, Query, UseGuards } from '@nestjs/common';
import { ChatService } from './chat.service';
import { AuthGuard } from '@nestjs/passport';
import { JwtGuards } from 'src/decorator/jwt.guard';

@Controller('chat')
export class ChatController {
  constructor(private chatService: ChatService) {}

  @Post('/create')
  @UseGuards(AuthGuard('jwt'))
  createChat(@Body() body: any) {
    return this.chatService.createChat(body);
  }
  @Get('/get')
  @UseGuards(AuthGuard('jwt'))
  getChats(@Query() params: any) {
    return this.chatService.getChatOfUser(params.my_id);
  }

  @Get('/get_by_id')
  @JwtGuards()
  getChatById(@Query() params: any) {
    return this.chatService.getChatById(params.room_id, params.my_id);
  }
}
