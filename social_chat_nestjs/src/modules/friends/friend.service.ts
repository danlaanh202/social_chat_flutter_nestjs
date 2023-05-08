import { Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
@Injectable({})
export class FriendService {
  constructor(private prismaService: PrismaService) {}
  async sendFriendRequest(body: any) {
    try {
      const friendRequest = await this.prismaService.friendRequest.create({
        data: {
          requester: { connect: { id: body.requester_id } },
          recipient: { connect: { id: body.recipient_id } },
          status: 'PENDING',
        },
      });
      return friendRequest;
    } catch (error) {
      throw new Error('Send friend request error');
    }
  }
  async acceptFriendRequest(requestId: string) {
    try {
      const updatedRequest = await this.prismaService.friendRequest.update({
        where: { id: requestId },
        data: {
          status: 'ACCEPTED',
        },
      });
      return updatedRequest;
    } catch (error) {
      throw new Error("Can't accept friend request");
    }
  }
  async removeFriendRequest(requestId: string) {
    try {
      const deletedRequest = await this.prismaService.friendRequest.delete({
        where: {
          id: requestId,
        },
      });
      return deletedRequest;
    } catch (error) {
      throw new Error("Can't remove friend request");
    }
  }
}
