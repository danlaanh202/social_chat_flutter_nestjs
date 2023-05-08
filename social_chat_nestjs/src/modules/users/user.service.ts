import { Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { FriendService } from '../friends/friend.service';

@Injectable({})
export class UserService {
  constructor(
    private prismaService: PrismaService,
    friendService: FriendService,
  ) {}

  async getUsers() {
    try {
      const users = await this.prismaService.user.findMany({});
      return users;
    } catch (error) {
      throw new Error('Something happened with api');
    }
  }
  async getMyFriends(userId: string, _searchQuery = '') {
    try {
      const friends = await this.prismaService.user.findUnique({
        where: {
          id: userId, // user ID cần lấy danh sách bạn bè
        },
        include: {
          sent_friend_requests: {
            where: {
              AND: [
                { status: 'ACCEPTED' },
                {
                  recipient: {
                    username: {
                      contains: _searchQuery,
                    },
                  },
                },
              ],
            },
            include: {
              recipient: true, // thông tin về recipient (user đã nhận yêu cầu kết bạn)
            },
          },
          received_friend_requests: {
            where: {
              AND: [
                { status: 'ACCEPTED' },
                {
                  requester: {
                    username: {
                      contains: _searchQuery,
                    },
                  },
                },
              ],
            },
            include: {
              requester: true, // thông tin về requester (user đã gửi yêu cầu kết bạn)
            },
          },
        },
      });
      const sentFriendRequests = friends.sent_friend_requests.map((fr) => {
        delete fr.recipient.password;
        return fr.recipient;
      });
      const receivedFriendRequests = friends.received_friend_requests.map(
        (fr) => {
          delete fr.requester.password;
          fr.requester;
        },
      );
      const myFriends = [...sentFriendRequests, ...receivedFriendRequests];
      return myFriends;
    } catch (error) {
      throw new Error('Error when get friends');
    }
  }
  async searchUsers(searchQuery: string, userId: string) {
    try {
      const users = await this.prismaService.user.findMany({
        where: {
          AND: [
            {
              NOT: {
                id: userId,
              },
            },
            {
              username: { contains: searchQuery },
            },
          ],
        },
        select: {
          id: true,
          username: true,
          email: true,
          password: false,
          sent_friend_requests: {
            where: {
              recipient_id: userId,
            },
            select: {
              id: true,
              status: true,
              requester: {
                select: {
                  id: true,
                },
              },
            },
          },
          received_friend_requests: {
            where: {
              requester_id: userId,
            },
            select: {
              id: true,
              status: true,
              recipient: {
                select: {
                  id: true,
                },
              },
            },
          },
        },
      });
      return users.map((_user) => {
        let friendStatus = null;
        if (_user.sent_friend_requests.length > 0) {
          const friendRequestSent = _user.sent_friend_requests[0];
          if (friendRequestSent.status === 'ACCEPTED') {
            friendStatus = 'FRIEND';
          } else {
            friendStatus = 'RECEIVED';
          }
        } else if (_user.received_friend_requests.length > 0) {
          const friendRequestReceived = _user.received_friend_requests[0];
          if (friendRequestReceived.status === 'ACCEPTED') {
            friendStatus = 'FRIEND';
          } else {
            friendStatus = 'SENT';
          }
        }
        return {
          id: _user.id,
          username: _user.username,
          email: _user.email,
          friend_status: friendStatus || 'NO_STATUS',
        };
      });
    } catch (error) {
      throw new Error(error);
    }
  }
  async searchSentUsers(searchQuery: string, userId: string) {
    try {
      const sentUsers = await this.prismaService.user.findUnique({
        where: {
          id: userId,
        },
        include: {
          sent_friend_requests: {
            where: {
              AND: [
                { status: 'PENDING' },
                {
                  recipient: {
                    username: {
                      contains: searchQuery,
                    },
                  },
                },
              ],
            },
            select: {
              recipient: true,
            },
          },
        },
      });
      return sentUsers.sent_friend_requests.map((item) => ({
        id: item.recipient.id,
        username: item.recipient.username,
        email: item.recipient.email,
        friend_status: 'SENT',
      }));
    } catch (error) {
      throw new Error(error);
    }
  }
  async searchReceivedUsers(searchQuery: string, userId: string) {
    try {
      const receivedUser = await this.prismaService.user.findUnique({
        where: {
          id: userId,
        },
        include: {
          received_friend_requests: {
            where: {
              AND: [
                { status: 'PENDING' },
                {
                  requester: {
                    username: {
                      contains: searchQuery,
                    },
                  },
                },
              ],
            },
            select: {
              requester: true,
            },
          },
        },
      });
      return receivedUser.received_friend_requests.map((item) => ({
        id: item.requester.id,
        username: item.requester.username,
        email: item.requester.email,
        friend_status: 'RECEIVED',
      }));
    } catch (error) {
      throw new Error(error);
    }
  }
}
