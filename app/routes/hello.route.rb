class App
  # root
  hash_branch "" do |r|
    r.is do
      "hello world"
      render("hello", locals: { world: "world"})
    end
  end
end
