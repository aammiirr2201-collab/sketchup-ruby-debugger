module AddThickness3mm

  def self.run
    model = Sketchup.active_model
    sel = model.selection

    unless sel.length == 1 && sel[0].is_a?(Sketchup::Face)
      UI.messagebox("لطفاً فقط یک صفحه (Face) انتخاب کن")
      return
    end

    face = sel[0]

    model.start_operation("Add 3mm Thickness", true)

    # گروه‌سازی
    group = model.entities.add_group
    group_entities = group.entities

    # کپی صفحه داخل گروه
    new_face = group_entities.add_face(face.vertices.map(&:position))

    # ضخامت 3 میلی‌متر
    new_face.pushpull(3.mm)

    model.commit_operation
  end

  unless file_loaded?(__FILE__)
    UI.menu("Extensions").add_item("افزودن ضخامت ۳ میلی‌متر") {
      self.run
    }
    file_loaded(__FILE__)
  end

end
