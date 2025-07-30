#!/bin/bash

# 遍历所有可能的fb设备
for i in {0..9}; do
    fb_device="/sys/class/graphics/fb$i"
    
    # 检查设备是否存在
    if [ -d "$fb_device" ]; then
        modes_file="$fb_device/modes"
        
        # 检查modes文件是否存在
        if [ -f "$modes_file" ]; then
            # 获取modes内容
            modes=$(cat "$modes_file")
            
            # 检查是否包含目标模式
            if echo "$modes" | grep -q "U:480x320p-0"; then
                echo "fb$i"
                exit 0
            fi
        fi
    fi
done

echo "[ERROR]: not found fb device with U:480x320p-0 mode"
exit 1
