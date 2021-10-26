package com.chyiiiiiiiiiiiiii.qiyu

import android.content.Context
import android.graphics.Bitmap
import android.graphics.drawable.Drawable
import com.bumptech.glide.Glide
import com.bumptech.glide.request.RequestOptions
import com.bumptech.glide.request.target.SimpleTarget
import com.bumptech.glide.request.transition.Transition
import com.qiyukf.unicorn.api.ImageLoaderListener
import com.qiyukf.unicorn.api.UnicornImageLoader

class QiyuGlideImageLoader(context: Context) : UnicornImageLoader {
    private val context: Context = context.applicationContext
    override fun loadImageSync(uri: String, width: Int, height: Int): Bitmap? {
        return null
    }

    override fun loadImage(uri: String, width: Int, height: Int, listener: ImageLoaderListener) {
        var imageWidth = width
        var imageHeight = height
        if (imageWidth <= 0 || imageHeight <= 0) {
            imageHeight = Int.MIN_VALUE
            imageWidth = imageHeight
        }
        val options = RequestOptions()
            .centerCrop()
        Glide.with(context).asBitmap().load(uri).apply(options)
            .into(object : SimpleTarget<Bitmap?>(imageWidth, imageHeight) {
                override fun onLoadFailed(errorDrawable: Drawable?) {
                    super.onLoadFailed(errorDrawable)
                    val t = Throwable("Glide - Error")
                    listener.onLoadFailed(t)
                }

                override fun onResourceReady(resource: Bitmap, transition: Transition<in Bitmap?>?) {
                    listener.onLoadComplete(resource)
                }
            })
    }

}