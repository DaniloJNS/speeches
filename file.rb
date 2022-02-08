path = 'public/exports/'
file = "dados_#{Time.now.to_i}.txt"
path = File.join(Rails.root, path, file)

input = Rails.root.join("#{Rails.root}/spec/fixtures/files/case.txt")
                                                            


conference = ImportService.call(File.open(input, 'r'))

file = ExportService.call conference

puts file.read
