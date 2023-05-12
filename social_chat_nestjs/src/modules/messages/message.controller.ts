import { MessageService } from './message.service';
import { Body, Controller, Get, Post, Query } from '@nestjs/common';
import { JwtGuards } from 'src/decorator/jwt.guard';
import { WebsocketGateway } from 'src/websocket/websocket.gateway';

@Controller('message')
export class MessageController {
  constructor(private readonly messageService: MessageService) {}

  @Post('/create')
  @JwtGuards()
  createChat(
    @Body() body: { content: String; chat_id: String; my_id: String },
  ) {
    return this.messageService.createMessage({
      content: body.content,
      chat_id: body.chat_id,
      my_id: body.my_id,
    });
  }

  @Get('/get')
  @JwtGuards()
  getMessagesOfChat(@Query() params: any) {
    return this.messageService.getMessageOfRoom(params.room_id);
  }
}
