export type Affected = number;

export type Result<T> = {
    status: "success" | "error";
    data: T;
    error: any;
};
