double test_fun(const double& x, std::ostream* pstream__)
{
  return sin(x) + x;
}

var test_fun(const var& x, std::ostream* pstream__)
{
  double a = x.val();
  double fa = sin(a) + a;
  double dfa_da = cos(a) + 1;
  return var(new precomp_v_vari(fa, x.vi_, dfa_da));
}
