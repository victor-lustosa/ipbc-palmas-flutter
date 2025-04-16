import { createClient, SupabaseClient } from 'jsr:@supabase/supabase-js@2'
import { corsHeaders } from '../_shared/cors.ts'

console.log(`Function "add-service" up and running!`)

Deno.serve(async (req: Request) => {
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders })
  }
  try {
     const body = await req.json()
    const supabaseUrl = Deno.env.get('SUPABASE_URL') ?? '';
    const supabaseAnonKey = Deno.env.get('SUPABASE_ANON_KEY') ?? '';

    if (!supabaseUrl || !supabaseAnonKey) {
      throw new Error("Supabase URL or ANON KEY is not set in the environment variables.");
    }
 
    const supabaseClient: SupabaseClient = createClient(supabaseUrl, supabaseAnonKey);

    const  LyricEntity = { id: 1, name: 'Denmark' }

    const { error } = await supabaseClient.from('lyric').insert({}).select()
  
    if (error) throw error;

    return new Response(JSON.stringify({ }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      status: 200,
    });
  } catch (error) {
    console.error("Error in function:", error.message)
    return new Response(JSON.stringify({ error: error.message }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      status: 400,
    });
  }
});