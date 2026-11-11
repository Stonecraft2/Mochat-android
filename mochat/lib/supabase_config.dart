
import 'package:supabase_flutter/supabase_flutter.dart';
const String supabaseUrl = 'https://ndvjepuyxpojjecqnnyc.supabase.co';
const String supabasePublishableKey = 'sb_publishable_D9v8mjgLJvOo1EAyzwN2Xw__IpEDtyW';

Future<void> initializeSupabase() async {
  await Supabase.initialize(
    url: supabaseUrl,
    publishableKey: supabasePublishableKey,
  );
}
