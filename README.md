# TabbReview – עמדות ביקורות לעסקים

## מבנה
```
sites/                  ← רק התיקייה הזו מתפרסמת ב-Cloudflare
  _headers              ← הגדרה אחת לכל האתרים (בלי שמירת גרסאות ישנות)
  test-super-mafteach/  ← אתר בדיקות: סופר מפתח טמבוריה (עסק 2, env = test)
    index.html          ← העמדה בטאבלט
    r/index.html        ← דף ההפניה של הסריקות
  daniel-bags/          ← לקוח: דניאל תיקים
supabase/               ← קובצי SQL (לא מתפרסמים)
  supabase-setup.sql    ← כל המסד + רשימת העסקים. אפשר להריץ שוב בלי נזק
  supabase-reset.sql    ← ⚠️ מוחק הכל. אחריו מריצים את setup
wrangler.jsonc          ← אומר ל-Cloudflare לפרסם את sites
```

## כתובות
- עמדה בטאבלט: `https://<הכתובת של הפרויקט>/<תיקיית הלקוח>/`
- מדבקת NFC: `https://<הכתובת של הפרויקט>/<תיקיית הלקוח>/r/?b=<slug>&s=nfc`
- בדיקה: להוסיף `#debug` לכתובת העמדה

## לקוח חדש
1. מעתיקים תיקייה של לקוח קיים בתוך `sites/` לשם חדש (אותיות קטנות באנגלית ומקפים).
2. ב-`index.html` וב-`r/index.html` מעדכנים את `DEFAULT_BIZ` ואת `FALLBACK` לפרטי הלקוח, ומעצבים את הדף.
3. ב-`supabase/supabase-setup.sql`, בחלק 7, מוסיפים שורה לעסק עם המספר הבא ועם אותו `slug`, ומריצים את כל הקובץ ב-Supabase.
4. דוחפים לגיטהאב. Cloudflare מפרסם לבד.

## חשוב
- לא להוסיף קובץ `_redirects` עם הפניה ל-Supabase: Cloudflare לא תומך בזה, והפרסום ייכשל.
- קובצי `_headers` ו-`_redirects` נקראים רק מהשורש של `sites/`, לא מתוך תיקיות הלקוחות.