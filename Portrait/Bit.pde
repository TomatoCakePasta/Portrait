class Bit {
  color c;
  float size;
  float x;
  float y;
  float b;
  
  float size_d;
  float color_d;
  
  // constructor
  Bit() {
    
  }
  
  void make() {
    fill((int)(255 * this.b));
    
    ellipse(this.x, this.y, this.size, this.size);
  }
  
  // 差をセット
  void setMove(float _size_d, float _color_d) {
    this.size_d = _size_d;
    this.color_d  = _color_d;  
  }
  
  // 円を動的に変更
  void move() {
     this.size += this.size_d;
     this.b += this.color_d;   
  }
  
  // 切替のタイミングでデータを取得
  void setData(color _c, float _size, float _x, float _y) {
    this.c = _c;
    // 色を数値に変換
    this.b = map(brightness(this.c), 0, 255, 0, 1);
    
    this.x = _x;
    this.y = _y;
  }
  
}
