jQuery.expr[':'].Contains = (a, i, m) ->
  (a.textContent or a.innerText or '').toUpperCase().indexOf(m[3].toUpperCase()) >= 0
