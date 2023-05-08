import { Body, Controller, Post, UseGuards } from '@nestjs/common';
import { ChatService } from './chat.service';
import { AuthGuard } from '@nestjs/passport';

@Controller('chat')
export class ChatController {
  constructor(private chatService: ChatService) {}

  @Post('/create')
  @UseGuards(AuthGuard('jwt'))
  createChat(@Body() body: any) {
    return this.chatService.createChat(body);
  }
}
