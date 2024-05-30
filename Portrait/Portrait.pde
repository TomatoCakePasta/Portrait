import gifAnimation.*;

ArrayList<PImage> img = new ArrayList<PImage>();
PImage tmp;

ArrayList<Bit> bits = new ArrayList<Bit>();
Bit tmp_bit;

int idx = 0;
int tiles = 70;  // 解像度
float k = 20;  // 画像切替の速さ
int imgs = 1;  // 使用画像の数

float cnt = 0;

float tileSize = 640.0 / tiles;

boolean flag;

int timer = 0;

import gifAnimation.*;

GifMaker gifExport;


void setup() {
  size(640, 640, P3D);
  
  for (int i = 0; i <= imgs; i++) {
    tmp = loadImage(i + ".jpg");
    img.add(tmp);
  }
  
  for (int i = 0; i < img.size(); i++) {
    img.get(i).resize(width, height);
  }
  
  for (int i = 0; i < tiles * tiles; i++) {
    tmp_bit = new Bit();
    
    bits.add(tmp_bit);
  }
  
  // 初回
  setNewData();
  
  // コメントアウトでgif形式でアップロード
  /*
  gifExport = new GifMaker(this, "portrait.gif");
  gifExport.setRepeat(0);
  gifExport.setQuality(10);
  gifExport.setDelay(20);
  */

  frameRate(60);
}

void draw() {
  background(0);
  
  translate(tileSize / 2, tileSize / 2);
  
  // 各点を描画
  for (int x = 0; x < tiles; x++) {
    for (int y = 0; y < tiles; y++) {
      strokeWeight(0.3);
      stroke(255);

      
      // 表示
      bits.get(tiles * x + y).make();
      
      // 必要があれば毎フレーム切替
      if (cnt < k * tiles * tiles) {
        // その座標のタイルの大きさを変える
        bits.get(tiles * x + y).move();
        cnt++;
      }
      else if (cnt == k * tiles * tiles) {
        setNewData();

        cnt++;
  
        flag = false;
      }
      
    }
  }
  
  if (!flag) {
    timer++;
    
    if (timer % 5 == 0) {
      Change();
      timer = 0;
    }
  }

  // コメントアウトでgif形式でアップロード
  // 保存するフレーム数を指定
  /*
  if (frameCount < 60 * 5) {
    gifExport.addFrame(); 
  }
  else {
    gifExport.finish();
  }
  */
}

void Change() {
  // 切替

  // 大きさの差を取得
  for (int x = 0; x < tiles; x++) {
    for (int y = 0; y < tiles; y++) {
      int tmp_idx = idx;
      
      // 現状
      color c1 = img.get(tmp_idx).get(int(x * tileSize), int(y * tileSize));
      float b1 = map(brightness(c1), 0, 255, 0, 1);
      
      tmp_idx++;
      tmp_idx %= img.size();
      
      // 次の画像
      color c2 = img.get(tmp_idx).get(int(x * tileSize), int(y * tileSize));
      float b2 = map(brightness(c2), 0, 255, 0, 1);
      
      // 差をセット
      bits.get(tiles * x + y).setMove(tileSize * ((b2 - b1) / k), (b2 - b1) / k);
      
    }
  }
  
  idx++;
  idx %= img.size();
  
  // 切替
  cnt = 0;
  
  flag = true;
}

void setNewData() {
    // データをセット
    for (int x = 0; x < tiles; x++) {
      for (int y = 0; y < tiles; y++) {
        color c = img.get(idx).get(int(x * tileSize), int(y * tileSize));
        float b = map(brightness(c), 0, 255, 0, 1);
        
        bits.get(tiles * x + y).setData(c, tileSize * b, tileSize * x, tileSize * y);
      }
    } 
}
