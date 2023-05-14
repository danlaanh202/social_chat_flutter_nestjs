import { ChatService } from './../chats/chat.service';

import { PrismaService } from './../prisma/prisma.service';
import { Injectable } from '@nestjs/common';

@Injectable({})
export class MessageService {
  constructor(
    private readonly prismaService: PrismaService,
    private chatService: ChatService,
  ) {}
  async createMessage(body: any) {
    try {
      if (!body.content || !body.chat_id || !body.my_id) {
        return;
      }
      const message = await this.prismaService.message.create({
        data: {
          content: body.content,
          chat: {
            connect: {
              id: body.chat_id,
            },
          },
          sender: {
            connect: {
              id: body.my_id,
            },
          },
        },
        include: {
          chat: {
            include: {
              members: {
                // do something here
                where: {
                  user: {
                    id: {
                      not: body.my_id,
                    },
                  },
                },
              },
            },
          },
        },
      });
      await this.chatService.updateIsViewed(body.chat_id, false);
      return message;
    } catch (error) {
      throw new Error(error);
    }
  }
  async getMessageOfRoom(roomId: any) {
    try {
      const messages = await this.prismaService.message.findMany({
        where: {
          chat_id: roomId,
        },
        include: {
          chat: true,
          sender: true,
        },
      });
      return messages;
    } catch (error) {
      throw new Error();
    }
  }
}
