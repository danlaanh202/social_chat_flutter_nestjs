import { SignInDto } from './../dto/auth.dto';
import { AuthService } from './../auth.service';
import { Injectable, UnauthorizedException } from '@nestjs/common';
import { PassportStrategy } from '@nestjs/passport';
import { Strategy } from 'passport-local';

@Injectable()
export class LocalStrategy extends PassportStrategy(Strategy, 'local') {
  constructor(private readonly authService: AuthService) {
    super({
      usernameField: 'username',
    });
  }
  validate(dto: SignInDto) {
    const user = this.authService.login(dto);
    if (!user) {
      throw new UnauthorizedException('signin failed!');
    }
    return user;
  }
}
