const axios = require('axios')
const axiosRetry = require('axios-retry');
const fs = require('fs');
const R = require('ramda')

axiosRetry(axios, { retries: 3 })
range = R.range(0, 2024)

function get(i) {
    return axios.get(`http://www.kanjidamage.com/kanji/${i}`)
}

async function main() {
    for (let i=584; i<2024; i++) {
        try {
            const response = await get(i)
            fs.writeFile(`data/${i}`, response.data, a => {
                console.log(`done: ${i}`)
            })
        } catch (e) {
            console.log(e)
        }
    }
}

try {
    main()
} catch (e) {
    console.log(e)
}
