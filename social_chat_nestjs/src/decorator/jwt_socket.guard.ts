import { JwtService } from '@nestjs/jwt';
import { CanActivate, Injectable } from '@nestjs/common';
import { Observable } from 'rxjs';
import { UserService } from 'src/modules/users/user.service';

export class WsGuard implements CanActivate {
  constructor(
    private userService: UserService,
    private jwtService: JwtService,
  ) {}

  canActivate(
    context: any,
  ): boolean | any | Promise<boolean | any> | Observable<boolean | any> {
    const bearerToken =
      context.args[0].handshake.headers.authorization?.split(' ')[1];
    try {
      const decoded = this.jwtService?.verify(bearerToken, {
        secret: process.env.SECRET_KEY,
      }) as any;
      return new Promise(async (resolve, reject) => {
        return await this.userService?.getUser(decoded.id).then((user) => {
          if (user) {
            resolve(user);
          } else {
            reject(false);
          }
        });
      });
    } catch (ex) {
      console.log(ex);
      return false;
    }
  }
}
