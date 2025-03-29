module ApplicationHelper
  def default_meta_tags
    {
      site: "STEPS",
      title: "子供の運動機能を記録・評価！",
      reverse: true, # "タイトル | サイト名" の形式で出力
      description: "STEPSは、子供の運動機能を記録し、成長を可視化できるWebアプリです。",
      keywords: "運動, 成長記録, 子供, Webアプリ",
      canonical: "rigid-ashli-kagawatoukairin1212-a6937945.koyeb.app",
      og: {
        title: "STEPS - 子供の運動機能を記録・評価！",
        description: "STEPSは、子供の運動機能を記録し、成長を可視化できるWebアプリです。",
        type: "website",
        url: "rigid-ashli-kagawatoukairin1212-a6937945.koyeb.app",
        image: image_url("ogp.png"),
        site_name: "STEPS"
      },
      twitter: {
        card: "summary_large_image",
        site: "@your_twitter_account",
        title: "STEPS - 子供の運動機能を記録・評価！",
        description: "STEPSは、子供の運動機能を記録し、成長を可視化できるWebアプリです。",
        image: image_url("ogp.png")
      }
    }
  end
end
