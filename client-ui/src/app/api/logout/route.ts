import {cookies} from "next/headers";
import {NextResponse} from "next/server";

export async function POST() {
    (await cookies()).delete("accessToken");
    (await cookies()).delete("email");
    return NextResponse.json(true,{ status: 201 });
}