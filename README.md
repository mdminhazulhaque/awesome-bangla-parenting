# Awesome Bangla Parenting

বাংলা ভাষাভাষী অভিভাবকদের জন্য কিউরেটেড রিসোর্স (ওয়েবসাইট, গ্রুপ, অ্যাপ, ইউটিউব চ্যানেল ইত্যাদি) – সহজ একটি স্ট্যাটিক সাইট হিসেবে পরিবেশিত।

## 🔧 Stack
- Jekyll (GitHub Pages)
- Bootstrap 5 + Bootstrap Icons
- Data source: `_data/parenting.json`

## 🚀 লোকাল ডেভেলপমেন্ট (Jekyll)
Prerequisites: Ruby (>= 3.1), Bundler

```bash
git clone https://github.com/mdminhazulhaque/awesome-bangla-parenting.git
cd awesome-bangla-parenting
bundle install
bundle exec jekyll serve --livereload
```

সাইট দেখা যাবে: http://127.0.0.1:4000

## 🗂 কাঠামো
```
_config.yml          # সাইট কনফিগ
_layouts/default.html# প্রধান লেআউট
_data/parenting.json # রিসোর্স ডেটা (আপনি এখানেই পরিবর্তন যোগ করবেন)
index.md             # ইনডেক্স পেজ (লেআউট রেন্ডার)
```

## ➕ নতুন রিসোর্স যুক্ত করার নিয়ম
সব কনটেন্ট `_data/parenting.json` ফাইলে JSON অবজেক্ট আকারে ক্যাটেগরি অনুসারে রাখা হয়। স্ট্রাকচার:

```jsonc
{
	"Websites": {
		"Example Site": "https://example.com"
	},
	"Facebook Groups": {
		"Example Group": "https://facebook.com/groups/example"
	}
}
```

### ধাপসমূহ
1. `/_data/parenting.json` ওপেন করুন
2. উপযুক্ত ক্যাটেগরির মধ্যে নতুন key-value জোড়া যোগ করুন
3. Key = প্রদর্শিত নাম, Value = URL (https, http নয় এমন হলে সাধারণত গ্রহণযোগ্য নয়)
4. কমা (`,`) ব্যবহারে সতর্ক থাকুন – JSON ট্রেইলিং কমা সাপোর্ট করে না
5. লোকালিতে `bundle exec jekyll build` অথবা `serve` রান করে ভিজ্যুয়ালি চেক করুন

### নতুন ক্যাটেগরি যোগ করতে চাইলে
নতুন ক্যাটেগরি নাম একটি নতুন অবজেক্ট key হিসেবে যোগ করুন এবং ভিতরে একইভাবে নাম: URL জোড়া দিন। উদাহরণ:
```jsonc
"Podcasts": {
	"Parenting Talk": "https://example.com/podcast"
}
```

## ✅ কনটেন্ট গাইডলাইন
- বিশ্বস্ত, কার্যকরী ও প্যারেন্টিং সম্পর্কিত হওয়া উচিত
- ভাঙা / রিডাইরেক্টেড / সন্দেহজনক লিংক এড়িয়ে চলুন
- আগের এন্ট্রি আছে কি না সার্চ করে নিন (ডুপ্লিকেট হ্রাস)
- ব্যক্তিগত ব্লগ হলে ধারাবাহিক প্যারেন্টিং কনটেন্ট থাকতে হবে

## 🔍 যাচাই (Validation)
JSON সিনট্যাক্স ভেরিফাই করতে দ্রুত:
```bash
python -m json.tool _data/parenting.json > /dev/null && echo "Valid JSON"
```

## 🛠 বিল্ড
```bash
bundle exec jekyll build
```
আউটপুট জেনারেট হবে `_site/` ডিরেক্টরিতে।

## 🤝 অবদান
Pull Request স্বাগতম! সংক্ষেপে:
1. ফর্ক করুন
2. নতুন ব্রাঞ্চ নিন
3. পরিবর্তন করুন (বিশেষ করে শুধু JSON এ হলে সবচেয়ে ভালো)
4. লোকাল বিল্ড পাস নিশ্চিত করুন
5. PR ওপেন করুন (পরিবর্তনের ছোট বিবরণ সহ)

## 📜 লাইসেন্স
MIT লাইসেন্স

---
আরও আইডিয়া / উন্নয়ন প্রস্তাব দিতে Issue খুলতে পারেন। ধন্যবাদ! 🙏
