module BooksHelper
    # Renders 0–5 stars from a numeric score (e.g., 4.2 → ★★★★☆)
    def star_row(score)
      filled = score.to_f.round.clamp(0, 5)
      empty  = 5 - filled
      content_tag(:span,
        ("★" * filled + "☆" * empty),
        class: "text-warning fs-5",
        aria: { label: "#{filled} out of 5 stars" }
      )
    end
end
