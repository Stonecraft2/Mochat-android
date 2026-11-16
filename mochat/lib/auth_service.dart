
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  static final _client = Supabase.instance.client;

    // Создание скрытого адреса на основе никнейма.
      static String _makeEmail(String nickname) {
          final normalized = nickname.trim().toLowerCase();

              final hash = sha256
                      .convert(utf8.encode(normalized))
                              .toString();

                                  return 'mochat_$hash@mochat.invalid';
                                    }

                                      // Проверка никнейма.
                                        static void _validate(String nickname, String password) {
                                            final nick = nickname.trim();

                                                if (!RegExp(r'^[A-Za-zА-Яа-яЁё0-9_]{1,15}$')
                                                        .hasMatch(nick)) {
                                                              throw Exception(
                                                                      'Никнейм: от 1 до 15 символов. '
                                                                              'Разрешены буквы, цифры и _.'
                                                                                    );
                                                                                        }

                                                                                            if (password.length < 6) {
                                                                                                  throw Exception('Пароль должен содержать минимум 6 символов.');
                                                                                                      }
                                                                                                        }

                                                                                                          // Регистрация нового пользователя.
                                                                                                            static Future<void> register(
                                                                                                                String nickname,
                                                                                                                    String password,
                                                                                                                      ) async {
                                                                                                                          final nick = nickname.trim();
                                                                                                                              _validate(nick, password);

                                                                                                                                  await _client.auth.signUp(
                                                                                                                                        email: _makeEmail(nick),
                                                                                                                                              password: password,
                                                                                                                                                    data: {
                                                                                                                                                            'nickname': nick,
                                                                                                                                                                  },
                                                                                                                                                                      );
                                                                                                                                                                        }

                                                                                                                                                                          // Вход существующего пользователя.
                                                                                                                                                                            static Future<void> login(
                                                                                                                                                                                String nickname,
                                                                                                                                                                                    String password,
                                                                                                                                                                                      ) async {
                                                                                                                                                                                          final nick = nickname.trim();
                                                                                                                                                                                              _validate(nick, password);

                                                                                                                                                                                                  await _client.auth.signInWithPassword(
                                                                                                                                                                                                        email: _makeEmail(nick),
                                                                                                                                                                                                              password: password,
                                                                                                                                                                                                                  );
                                                                                                                                                                                                                    }

                                                                                                                                                                                                                      // Выход из аккаунта.
                                                                                                                                                                                                                        static Future<void> logout() async {
                                                                                                                                                                                                                            await _client.auth.signOut();
                                                                                                                                                                                                                              }
                                                                                                                                                                                                                             // Проверка роли пользователя.
                                                                                                                                                                                                                               static Future<String?> getUserRole() async {
                                                                                                                                                                                                                                   final user = _client.auth.currentUser;
                                                                                                                                                                                                                                   
                                                                                                                                                                                                                                       if (user == null) return null;
                                                                                                                                                                                                                                       
                                                                                                                                                                                                                                           final result = await _client
                                                                                                                                                                                                                                                   .from('user_roles')
                                                                                                                                                                                                                                                           .select('role')
                                                                                                                                                                                                                                                                   .eq('user_id', user.id)
                                                                                                                                                                                                                                                                           .maybeSingle();
                                                                                                                                                                                                                                                                           
                                                                                                                                                                                                                                                                               return result?['role'] as String?;
                                                                                                                                                                                                                                                                                 }
                                                                                                                                                                                                                                                                                    }
                                                                                                                                                                                                                              