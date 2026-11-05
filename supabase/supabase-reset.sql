-- =====================================================================
--  ⚠️ איפוס מלא: מוחק את כל הטבלאות ואת כל הנתונים.
--     כל העסקים וכל הסריקות נמחקים, כולל של לקוחות אמיתיים. אין דרך לשחזר.
--
--  להריץ רק אם באמת רוצים להתחיל מאפס. אחרי זה מריצים את supabase-setup.sql,
--  שבונה הכל מחדש עם אותם עסקים ואותם מספרים.
--
--  הכל רץ כפעולה אחת: אם משהו נכשל, שום דבר לא נמחק.
-- =====================================================================
begin;

drop view if exists public.events_view;
drop view if exists public.monthly_summary;
drop function if exists public.log_event(text, text, text, text);
drop function if exists public.latest_scan(text);
drop table if exists public.events cascade;
drop table if exists public.businesses cascade;

commit;