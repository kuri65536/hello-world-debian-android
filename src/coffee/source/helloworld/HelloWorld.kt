package coffee.source.helloworld

import android.app.Activity
import android.os.Bundle
import android.widget.TextView

class HelloWorld: Activity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val view = findViewById(R.id.my_text) as TextView
        view.text = "Hello, kotlin world!"
    }
}
