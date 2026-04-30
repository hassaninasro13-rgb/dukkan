/**
 * Service Worker — دكّان
 * ملاحظة: الكاش السابق كان يستخدم caches.match لكل الطلبات؛
 * في بعض الحالات قد يُضلِل المتصفح بين مفاتيح الطلب والاستجابة المخبأة لـ / و index.
 *
 * ضع SW_DISABLED = true مؤقتاً لتعطيل الكاش بالكامل عند اختبار مشاكل التوجيه.
 */
const CACHE = 'dukkan-v2';
const FILES = ['./', './merchant-dashboard.html', './manifest.json', './icon-192.png', './icon-512.png'];

/** true = لا تثبيت كاش ولا مطابقة كاش؛ كل الطلبات من الشبكة (اختبار فقط) */
const SW_DISABLED = false;

self.addEventListener('install', (e) => {
  if (SW_DISABLED) {
    self.skipWaiting();
    return;
  }
  e.waitUntil(caches.open(CACHE).then((c) => c.addAll(FILES)));
});

self.addEventListener('activate', (e) => {
  e.waitUntil(
    caches
      .keys()
      .then((keys) =>
        Promise.all(keys.filter((k) => k !== CACHE).map((k) => caches.delete(k)))
      )
      .then(() => self.clients.claim())
  );
});

function isMerchantDashboardNavigate(request) {
  if (request.mode !== 'navigate') return false;
  let path;
  try {
    path = new URL(request.url).pathname;
  } catch {
    return false;
  }
  path = path.replace(/\/$/, '') || '/';
  return (
    path === '/merchant-dashboard' ||
    path === '/merchant-dashboard.html' ||
    path.endsWith('/merchant-dashboard') ||
    path.endsWith('/merchant-dashboard.html')
  );
}

self.addEventListener('fetch', (e) => {
  const req = e.request;

  if (SW_DISABLED) {
    e.respondWith(fetch(req));
    return;
  }

  // صفحة لوحة التاجر: دائماً من الشبكة — لا نخدم index أو / من الكاش بالخطأ
  if (isMerchantDashboardNavigate(req)) {
    e.respondWith(fetch(req));
    return;
  }

  e.respondWith(caches.match(req).then((r) => r || fetch(req)));
});
