class Size < ActiveHash::Base
  self.data = [
    {id: 1, name: 'XXS' }, {id: 2, name: 'XS' },{id: 3, name: 'S' },
    {id: 4, name: 'M' }, {id: 5, name: 'L' },{id: 6, name: 'XL' },
    {id: 7, name: 'XXL' }, {id: 8, name: 'FREE SIZE' },{id: 9, name: 'なし・その他' }
  ]
end