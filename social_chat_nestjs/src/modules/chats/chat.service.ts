import { Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';

@Injectable({})
export class ChatService {
  constructor(private prismaService: PrismaService) {}
  async createChat(body: any) {
    try {
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
}
