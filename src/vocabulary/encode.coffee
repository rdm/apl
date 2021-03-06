addVocabulary

  # Encode (`⊤`)
  #
  # 1760 3 12⊤75    <=> 2 0 3
  # 3 12⊤75         <=> 0 3
  # 100000 12⊤75    <=> 6 3
  # 16 16 16 16⊤100 <=> 0 0 6 4
  # 1760 3 12⊤75.3  <=> 2 0 (75.3-72)
  # 0 1⊤75.3        <=> 75 (75.3-75)
  #
  # 2 2 2 2 2⊤1 2 3 4 5 <=> (5 5 ⍴
  # ...                      0 0 0 0 0
  # ...                      0 0 0 0 0
  # ...                      0 0 0 1 1
  # ...                      0 1 1 0 0
  # ...                      1 0 1 0 1)
  #
  # 10⊤5 15 125 <=> 5 5 5
  # 0 10⊤5 15 125 <=> 2 3⍴ 0 1 12 5 5 5
  #
  # (8 3⍴ 2 0 0
  # ...   2 0 0
  # ...   2 0 0
  # ...   2 0 0
  # ...   2 8 0
  # ...   2 8 0
  # ...   2 8 16
  # ...   2 8 16) ⊤ 75
  # ...       <=> (8 3⍴
  # ...            0 0 0
  # ...            1 0 0
  # ...            0 0 0
  # ...            0 0 0
  # ...            1 0 0
  # ...            0 1 0
  # ...            1 1 4
  # ...            1 3 11)
  '⊤': (⍵, ⍺) ->
    assert ⍺
    a = ⍺.toArray()
    b = ⍵.toArray()
    shape = ⍴(⍺).concat ⍴ ⍵
    data = Array prod shape
    n = if ⍴⍴ ⍺ then ⍴(⍺)[0] else 1
    m = a.length / n
    for i in [0...m]
      for y, j in b
        if isNeg = (y < 0) then y = -y
        for k in [n - 1 .. 0] by -1
          x = a[k * m + i]
          if x is 0
            data[(k * m + i) * b.length + j] = y
            y = 0
          else
            data[(k * m + i) * b.length + j] = y % x
            y = Math.round((y - (y % x)) / x)
    new APLArray data, shape
