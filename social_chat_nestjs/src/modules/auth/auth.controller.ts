import { Body, Controller, Get, Post, Req, UseGuards } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { AuthService } from './auth.service';
import { GetUser } from 'src/decorator/get-user.decorator';
import { SignInDto, SignUpDto } from './dto/auth.dto';

@Controller('auth')
export class AuthController {
  constructor(
    private authService: AuthService, // private jwtService: JwtService,
  ) {}
  @Get('/test1')
  testApi() {
    return 'cec';
  }
  @Post('/sign-up')
  async signUp(@Body() myDto: SignUpDto) {
    return this.authService.register(myDto);
  }

  @Post('/sign-in')
  async signIn(@Body() body: SignInDto) {
    return this.authService.login(body);
  }
}
