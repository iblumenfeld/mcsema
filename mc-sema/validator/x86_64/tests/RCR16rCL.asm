BITS 64
;TEST_FILE_META_BEGIN
;TEST_TYPE=TEST_F
;TEST_IGNOREFLAGS=FLAG_OF
;TEST_FILE_META_END
    ; RCR16rCL
    mov bx, 0x414
    mov cl, 0x3
    ;TEST_BEGIN_RECORDING
    rcr bx, cl
    ;TEST_END_RECORDING

