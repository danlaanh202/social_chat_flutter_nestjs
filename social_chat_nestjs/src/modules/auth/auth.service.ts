import * as bcrypt from 'bcrypt';
import { ForbiddenException, Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';

import { SignUpDto, SignInDto } from './dto/auth.dto';
import { JwtService } from '@nestjs/jwt';

@Injectable({})
export class AuthService {
  constructor(
    private prismaService: PrismaService,
    private jwtService: JwtService,
  ) {}
  async register(authDto: SignUpDto) {
    try {
      const salt = await bcrypt.genSalt();
      const hashedPassword = await bcrypt.hash(authDto.password, salt);
      const user = await this.prismaService.user.create({
        data: {
          email: authDto.email,
          username: authDto.username,
          password: hashedPassword,
        },
        select: {
          id: true,
          email: true,
        },
      });
      return user;
    } catch (error) {
      throw new Error(error);
    }
  }
  async login(dto: SignInDto) {
    try {
      const user = await this.prismaService.user.findUnique({
        where: {
          username: dto.username,
        },
      });
      if (!user) {
        throw new ForbiddenException('User not found');
      }
      const isMatch = await bcrypt.compare(dto.password, user.password);

      if (!isMatch) {
        throw new Error('Password not true');
      }
      delete user.password;
      return { accessToken: this.jwtService.sign(user), ...user };
    } catch (error) {
      throw new Error(error + 'authService');
    }
  }
}
