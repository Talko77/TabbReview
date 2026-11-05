-- =====================================================================
--  ניקוי ומספור מחדש של העסקים
--
--  1) מוחק את כל האירועים שלא שייכים לעסק 3
--  2) עסק 3 (הלקוח האמיתי) הופך ל-id = 1, והאירועים שלו עוברים איתו
--  3) סופר מפתח (super-mafteach) הופך ל-id = 2 – עסק הבדיקות
--  4) העסק החדש הבא יקבל id = 3
--
--  ⚠️ מחיקת האירועים היא סופית. להריץ פעם אחת בלבד.
--  הכל רץ כפעולה אחת: אם משהו נכשל, שום דבר לא משתנה.
--  מדביקים את כל הקובץ ב-SQL Editor ולוחצים Run.
-- =====================================================================
begin;

-- 0) בדיקות לפני שנוגעים במשהו
do $$
begin
  if not exists (select 1 from public.businesses where id = 3) then
    raise exception 'אין עסק עם id = 3 – לא שיניתי כלום';
  end if;
  if not exists (select 1 from public.businesses where slug = 'super-mafteach') then
    raise exception 'לא נמצא עסק super-mafteach – לא שיניתי כלום';
  end if;
  if exists (select 1 from public.businesses where id = 3 and slug = 'super-mafteach') then
    raise exception 'עסק 3 הוא סופר מפתח עצמו – לא שיניתי כלום';
  end if;
  if exists (select 1 from public.businesses where id <> 3 and slug <> 'super-mafteach') then
    raise exception 'יש עסקים נוספים מלבד 3 וסופר מפתח – צריך להחליט מה לעשות איתם קודם';
  end if;
end $$;

-- 1) מחיקת כל האירועים שלא של עסק 3
delete from public.events where business_id <> 3;

-- 2) מורידים זמנית את הקישור בין האירועים לעסקים, כדי שאפשר יהיה לשנות מספרים
alter table public.events drop constraint events_business_id_fkey;

-- 3) מספור מחדש (דרך מספרים זמניים שליליים, כדי ששני עסקים לא יקבלו אותו מספר)
update public.businesses set id = -1 where id = 3;
update public.businesses set id = -2 where slug = 'super-mafteach';
update public.businesses set id = 1  where id = -1;
update public.businesses set id = 2  where id = -2;
update public.events     set business_id = 1 where business_id = 3;

-- 4) מחזירים את הקישור בדיוק כמו שהיה
alter table public.events
  add constraint events_business_id_fkey
  foreign key (business_id) references public.businesses (id) on delete restrict;

-- 5) המונה של העסקים: העסק הבא שיתווסף יקבל 3
select setval(pg_get_serial_sequence('public.businesses', 'id'), 2);

commit;

-- בדיקה
select id, slug, name from public.businesses order by id;
select business_id, count(*) from public.events group by business_id;
