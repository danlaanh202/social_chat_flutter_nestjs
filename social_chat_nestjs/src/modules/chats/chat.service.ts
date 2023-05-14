import { Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';

@Injectable({})
export class ChatService {
  constructor(private prismaService: PrismaService) {}
  async createChat(body: any) {
    try {
      const existedChat = await this.prismaService.chat.findFirst({
        where: {
          AND: [
            {
              members: {
                some: {
                  user_id: body.my_id,
                },
              },
            },
            {
              members: {
                some: {
                  user_id: body.recipient_id,
                },
              },
            },
          ],
        },
        include: {
          members: {
            where: {
              user_id: {
                not: body.my_id,
              },
            },
            include: {
              user: true,
            },
          },
          messages: {
            orderBy: {
              created_at: 'desc',
            },
            take: 1,
          },
        },
      });
      if (existedChat) {
        return existedChat;
      }
      const chat = await this.prismaService.chat.create({
        data: {
          name: body.name || 'New Chat',
          created_by: { connect: { id: body.my_id } },
          members: {
            create: [
              { user: { connect: { id: body.my_id } } },
              { user: { connect: { id: body.recipient_id } } },
            ],
          },
        },
      });
      return chat;
    } catch (error) {
      throw new Error('Error in chat service');
    }
  }
  async getChatOfUser(user_id: string) {
    try {
      const chats = await this.prismaService.chat.findMany({
        where: {
          members: {
            some: {
              user_id: user_id,
            },
          },
        },
        include: {
          members: {
            where: {
              user_id: {
                not: user_id,
              },
            },
            include: {
              user: true,
            },
          },
          messages: {
            orderBy: {
              created_at: 'desc',
            },
            take: 1,
          },
        },
      });
      console.log(chats);
      return chats;
    } catch (error) {}
  }
  async getChatById(room_id: string, my_id: string) {
    try {
      const chat = await this.prismaService.chat.findFirst({
        where: {
          id: room_id,
        },
        include: {
          members: {
            where: {
              user_id: {
                not: my_id,
              },
            },
            include: {
              user: true,
            },
          },
          messages: {
            orderBy: {
              created_at: 'desc',
            },
            take: 1,
          },
        },
      });
      return chat;
    } catch (error) {
      throw new Error("Can't get chat by id");
    }
  }
  async updateIsViewed(room_id: string, is_viewed: boolean) {
    try {
      const chat = await this.prismaService.chat.update({
        where: {
          id: room_id,
        },
        data: {
          is_last_message_viewed: is_viewed,
        },
      });
      return chat;
    } catch (error) {
      throw new Error('can not update is_viewed status');
    }
  }
}
