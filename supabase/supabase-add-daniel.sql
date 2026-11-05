-- =====================================================================
--  הוספת "דניאל תיקים" כעסק במסד – מריצים פעם אחת ב-SQL Editor (Run)
--  העסק מקבל אוטומטית את המספר הבא (id). אפשר להריץ שוב בלי נזק:
--  אם העסק כבר קיים, הפרטים שלו מתעדכנים.
-- =====================================================================
insert into public.businesses (slug, name, address, place_id, maps_query, whatsapp, whatsapp_text)
values (
  'daniel-bags',
  'דניאל תיקים ארנקים ומזוודות',
  'דיזנגוף סנטר, תל אביב',
  'ChIJ21RNYIBLHRURUp9x1sbOU9w',
  'דניאל תיקים ארנקים ומזוודות דיזנגוף סנטר תל אביב',
  '97236296137',
  'שלום, יש לי הערה על הביקור שלי בחנות דניאל:'
)
on conflict (slug) do update set
  name = excluded.name,
  address = excluded.address,
  place_id = excluded.place_id,
  maps_query = excluded.maps_query,
  whatsapp = excluded.whatsapp,
  whatsapp_text = excluded.whatsapp_text,
  active = true;

-- בדיקה: כל העסקים והמספרים שלהם
select * from public.businesses order by created_at;
