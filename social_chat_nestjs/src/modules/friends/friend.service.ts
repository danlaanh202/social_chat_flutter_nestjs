import { Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';

@Injectable({})
export class FriendService {
  constructor(private prismaService: PrismaService) {}
  async sendFriendRequest(recipientId: string, requesterId: string) {
    try {
      const friendRequest = await this.prismaService.friendRequest.create({
        data: {
          requester: { connect: { id: requesterId } },
          recipient: { connect: { id: recipientId } },
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

  async acceptFriendRequestByUserIds(requesterId: string, recipientId: string) {
    try {
      const updatedRequest = await this.prismaService.friendRequest.updateMany({
        where: {
          AND: [{ requester_id: requesterId }, { recipient_id: recipientId }],
        },
        data: {
          status: 'ACCEPTED',
        },
      });
      return updatedRequest;
    } catch (error) {
      throw new Error('Accept error');
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
  async removeFriendByUserIds(id1: string, id2: string) {
    try {
      const deletedRequest = await this.prismaService.friendRequest.deleteMany({
        where: {
          OR: [
            { AND: [{ requester_id: id1 }, { recipient_id: id2 }] },
            { AND: [{ requester_id: id2 }, { recipient_id: id1 }] },
          ],
        },
      });
      return deletedRequest;
    } catch (error) {
      throw new Error("Can't remove");
    }
  }
}
