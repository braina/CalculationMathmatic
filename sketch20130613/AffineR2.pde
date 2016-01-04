class AffineR2 {
  float a, b, c, d;
  float p, q;
  AffineR2(float aa, float bb, float cc, float dd, float pp, float qq) {
    a = aa;
    b = bb;
    c = cc;
    d = dd;
    p = pp;
    q = qq;


  }
  boolean isAffineR2() {
    if(a*d-b*c != 0) return true;
    else return false;
  }
  PVector translate(PVector pt) {
        return new PVector(
                a* pt.x + b * pt.y +p,
                c* pt.x + d * pt.y +q            
            );
  }
}

AffineR2 prod(AffineR2 f, AffineR2 g) {
    return new AffineR2(
        f.a*g.a + f.b*g.c , f.a*g.b + f.b*g.d      ,
        f.c*g.a + f.d*g.c , f.c*g.b + f.d*g.d      ,
        f.a*g.p + f.b*g.q + f.p, f.c*g.p + f.d*g.q + f.q
        );
}
