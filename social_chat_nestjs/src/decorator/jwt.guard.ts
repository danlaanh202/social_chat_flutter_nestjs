import { AuthGuard } from '@nestjs/passport';
import { applyDecorators, UseGuards } from '@nestjs/common';

export const JwtGuards = () => {
  return applyDecorators(UseGuards(AuthGuard('jwt')));
};
