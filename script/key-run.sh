#!/usr/bin/gosh
(use gauche.termios)
;; http://d.hatena.ne.jp/rui314/20070319/p1
;; 端末を非カノニカルモードに変更して1文字を読む手続き。
;; リターンするまえに端末のモードを元に戻す。
(define (read-single-char port)
  (let* ((attr (sys-tcgetattr port))
         (lflag (slot-ref attr 'lflag)))
    (dynamic-wind
      (lambda ()
        (slot-set! attr 'lflag (logand lflag (lognot ICANON)))
        (sys-tcsetattr port TCSAFLUSH attr))
      (lambda ()
        (read-char port))
      (lambda ()
        (slot-set! attr 'lflag lflag)
        (sys-tcsetattr port TCSANOW attr)))))

;; プログラムのエントリポイント
(define (main args)
  ;;(display "Press any key: ")
  ;; カレント出力ポートは行バッファリングなので、明示的にフラッシュする。
  ;; 上のdisplayは改行を含んでいないので、フラッシュしなければ何も出力されない。
  (flush)
   (let1 c (read-single-char (current-input-port))
    ;; (format #t "\ngot \"~a\" (UCS code 0x~X)\n"
    (format #t "\n~a ~X\n"
            c (char->ucs c)))
  0)
