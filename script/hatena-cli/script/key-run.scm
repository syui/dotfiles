#!/usr/bin/env gosh
(use gauche.termios)
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

(define (main args)
  (flush)
   (let1 c (read-single-char (current-input-port))
    (format #t "\n~a ~X\n"
            c (char->ucs c)))
0)
